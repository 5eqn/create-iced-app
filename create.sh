# Create folder for the project
mkdir $1
cd $1

# Write Cargo.toml
cat << EOF >> ./Cargo.toml
[package]
name = "$1"
version = "0.1.0"
edition = "2021"
publish = false

[dependencies]
iced = "0.9"
EOF

# Add a demo of a counter
mkdir ./src
cat << EOF >> ./src/main.rs
use iced::widget::{button, column, text};
use iced::{Alignment, Element, Sandbox, Settings};

pub fn main() -> iced::Result {
    Counter::run(Settings::default())
}

struct Counter {
    value: i32,
}

#[derive(Debug, Clone, Copy)]
enum Message {
    IncrementPressed,
    DecrementPressed,
}

impl Sandbox for Counter {
    type Message = Message;

    fn new() -> Self {
        Self { value: 0 }
    }

    fn title(&self) -> String {
        String::from("Counter - Iced")
    }

    fn update(&mut self, message: Message) {
        match message {
            Message::IncrementPressed => {
                self.value += 1;
            }
            Message::DecrementPressed => {
                self.value -= 1;
            }
        }
    }

    fn view(&self) -> Element<Message> {
        column![
            button("Increment").on_press(Message::IncrementPressed),
            text(self.value).size(50),
            button("Decrement").on_press(Message::DecrementPressed)
        ]
        .padding(20)
        .align_items(Alignment::Center)
        .into()
    }
}
EOF

# Init git
git init

# Add .gitignore
cat << EOF >> ./.gitignore
target/**
EOF

# Inform the result
echo "Iced project \"$1\" is successfully created!"
