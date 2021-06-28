package main

import (
	"github.com/go-telegram-bot-api/telegram-bot-api"
	"log"
	"regexp"
	"strconv"
)

func main() {
	bot, err := tgbotapi.NewBotAPI("Your bot token")
	tasks := [...]string{"Ansible assignment", "Bash script", "Telegram bot", "Bash script with github API", "Docker task"}
	links := [...]string{"https://github.com/ochernyavskyi/devops/tree/master/task1", "https://github.com/ochernyavskyi/devops/tree/master/task2", "https://github.com/ochernyavskyi/devops/tree/master/task3", "https://github.com/ochernyavskyi/devops/tree/master/task4", "https://github.com/ochernyavskyi/devops/tree/master/task5"}
	var commandPat = regexp.MustCompile(`^task[0-9]`)

	if err != nil {
		log.Panic(err)
	}

	bot.Debug = true

	log.Printf("Authorized on account %s", bot.Self.UserName)

	u := tgbotapi.NewUpdate(0)
	u.Timeout = 60

	updates, err := bot.GetUpdatesChan(u)

	for update := range updates {
		if update.Message == nil { // ignore any non-Message Updates
			continue
		}
		log.Printf("[%s] %s", update.Message.From.UserName, update.Message.Text)

		if update.Message.IsCommand() {
			msg := tgbotapi.NewMessage(update.Message.Chat.ID, "")
			switch cmd := update.Message.Command(); {
			case cmd == "start":
            			msg.Text = "Please type /help - to see all available commands"
			case cmd == "help":
				msg.ParseMode = "html"
				msg.Text = "The commands of this bot are following:\n /homerep - display home repository\n /tasks - display the list of all tasks\n /task# - (# is a number of task) will give U the link for this task."
			case cmd == "homerep":
				msg.Text = "https://github.com/ochernyavskyi/devops :)"
			case cmd == "tasks":
				msg.ParseMode = "html"
				msg.Text = "The list of completed tasks:\n"
				for i := 0; i < len(tasks); i++ {
					msg.Text = msg.Text + strconv.Itoa(i+1) + ". " + tasks[i] + "  -  " + "<a href='" + links[i] + "'> <b>link</b></a>" + "\n"
				}
			case commandPat.MatchString(cmd):
				cmd := cmd[4:5]
				taskIndex, _ := strconv.Atoi(cmd)
				if taskIndex <= len(links) {
					for i := taskIndex; i <= (taskIndex); i++ {
						msg.Text = links[i-1]
					}
				} else {
					msg.Text = "No such task or it is not ready"
				}
			default:
				msg.Text = "I don't know that command"
			}
			bot.Send(msg)
		}
	}
}
