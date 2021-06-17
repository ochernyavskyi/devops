package main

import (
	"log"
    "strconv"
//     "regexp"
	"github.com/go-telegram-bot-api/telegram-bot-api"
)

func main() {
	bot, err := tgbotapi.NewBotAPI("")
	tasks := [...]string{"Ansible assignment", "Bash script"}
	links := [...]string{"https://github.com/ochernyavskyi/devops/tree/master/task1", "https://github.com/ochernyavskyi/devops/tree/master/task2"}
// 	var currentTask = regexp.MustCompile(`^task#.`)

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
			switch update.Message.Command() {
			case "help":
				msg.Text = "type /sayhi or /status."
			case "homerep":
				msg.Text = "https://github.com/ochernyavskyi/devops :)"
			case "tasks":
			    msg.ParseMode = "html"
			    msg.Text = "The list of completed tasks:\n"
			    for i := 0; i < len(tasks); i++ {
       				msg.Text =  msg.Text + strconv.Itoa(i+1) + ". " + tasks[i] +  "  -  " + "<a href='"+links[i] +"'> <b>link</b></a>" + "\n"
                }
			case update.Message.Command == "^task#.":
				msg.ParseMode = "html"
				msg.Text = "This is test"
			default:
				msg.Text = "I don't know that command"
			}
			bot.Send(msg)
		}
}
}
