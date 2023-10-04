/*

 MyStory.swift
 Explore_SwiftUI_V3

 How to create a View file with keyboard and Xcode commands:

    * Command Key (Splat) N -> Swift UI View

 References:

 https://developer.apple.com/tutorials/sample-apps/chooseyourownstory

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/SwiftUI/App/body-swift.property

 https://developer.apple.com/documentation/SwiftUI/WindowGroup

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/uikit/uiimage/configuring_and_displaying_symbol_images_in_your_ui

 https://developer.apple.com/videos/play/wwdc2019/206

 https://developer.apple.com/videos/play/wwdc2020/10207

 https://developer.apple.com/videos/play/wwdc2021/10097

 https://developer.apple.com/videos/play/wwdc2022/10157

 https://developer.apple.com/videos/play/wwdc2023/10197

 Created on 10/3/2023 with Swift 5.9, Xcode 15.0

*/

import SwiftUI

let  story = Story(pages: [

    StoryPage( // 0
        """
        Welcome to Choose Your Own Story
        🥖🍪Bake Off!🥐🍰

        You enter a local baking competition at the country fair 🎪. It's a beautiful summer day and you
        are excited! When you enter the room, you look around to see ten identical stations.

        Each station is stocked with bowls of different sizes, spatulas, spoons, and a standing mixer. You
        are the third to arrive, so there are many stations still available. Where do you sit?
        """,
        choices: [
            Choice(text: "Front row!", destination: 1),
            Choice(text: "Find somewhere in the middle", destination: 1),
            Choice(text: "Back of the room", destination: 2),
        ]
    ),

    StoryPage( //1
        """
        Luckily, some nice people fill in around you and wave politely. The directions sounds fun! Make a
        sponge cake you would have wanted as a child for your birthday, focusing on the decorations and theme.
        The top three bakes will win a cash prize. You start with a theme.
        """,
        choices: [
            Choice(text: "Trains", destination: 3),
            Choice(text: "Castles", destination: 5),
            Choice(text: "Rainbows", destination: 6),
            Choice(text: "Woodland creatures", destination: 5),
            Choice(text: "Outer space", destination: 3),
        ]
    ),

    StoryPage( //2
        """
        Oh no. There is a very loud person next to you. You can barely hear the directions in the back of the room.
        You think they said something about a birthday cake. Luckily, the person in front of you whispers a brief review
        of what they said...glazing over a few things. “A birthday cake I would have wanted as a kid.” Hmm? You think back
        to your favorite cake.
        """,
        choices: [
            Choice(text: "Chocolate", destination: 4),
            Choice(text: "Red velvet", destination: 4),
            Choice(text: "Vanilla confetti", destination: 5),
            Choice(text: "Strawberry shortcake", destination: 3),
        ]
    ),

    StoryPage( //3
        """
        Great choice! Now you just need to make the sponge cake and start thinking about the toppings. You scan the selection
        on the table and start planning your toppings. In addition to all the colorful icing, you choose...
        """,
        choices: [
            Choice(text: "Sprinkles", destination: 8),
            Choice(text: "Berries", destination: 7),
            Choice(text: "Chocolate", destination: 9),
        ]
    ),

    StoryPage( //4
        """
        Okay, you seem to be in the clear. Everyone else is busy working on their cakes and you are too...only their cakes all look the same.
        You shrug it off thinking your cake is going to be unique and special. The judges come over and ask you what’s going to go
        on top of your cake. You tell them:
        """,
        choices: [
            Choice(text: "Piped buttercream frosting", destination: 13),
            Choice(text: "Fondant icing", destination: 7),
        ]
    ),

    StoryPage( //5
        """
        The judges come around to ask you about your cake. You are so excited to tell them about your toppings, which include:
        """,
        choices: [
            Choice(text: "Marzipan figurines", destination: 12),
            Choice(text: "Fondant figurines", destination: 14),
        ]
    ),

    StoryPage( // 6
        """
        The judges come around to ask you what you are planning. You tell them all about your rainbow-themed cake. One of the things you tell them is:
        """,
        choices: [
            Choice(text: "It’s in the shape of a rainbow.", destination: 15),
            Choice(text: "It has multicolored candies on the outside.", destination: 10),
            Choice(text: "It has marshmallow clouds.", destination: 11),
        ]
    ),

    StoryPage( // 7
        """
        There is so much available to decorate with; your cake keeps getting better and better. You notice some of your neighbors are using some decorations
        you didn’t see on the table. What do you do?
        """,
        choices: [
            Choice(text: "Pop over to your neighbor’s bench and ask where they got their toppings.", destination: 16),
            Choice(text: "Keep working away, your cake will be great even without the specialty item.", destination: 20),
        ]
    ),

    StoryPage( // 8
        """
        You are running out of time, so you put your cake in the freezer to speed things up. You check it after ten minutes. What do you do?
        """,
        choices: [
            Choice(text: "Pipe the decorations onto parchment paper. You can transfer them at the last minute.", destination: 17),
            Choice(text: "Start decorating, you don’t have a minute to waste.", destination: 18),
        ]
    ),

    StoryPage( // 9
        """
        You are feeling good about your timing and start creating your design. You want your theme to come to life, so you decide to upgrade
        your flat design to become 3D. You head over to the table of supplies and grab:
        """,
        choices: [
            Choice(text: "Marzipan, and lots of it!", destination: 19),
            Choice(text: "Several bags of different color icing.", destination: 20),
        ]
    ),

    StoryPage( // 10
        """
        When you head to the decorations table to get some candy, you find red, orange, yellow, green, and purple candies, but no blue
        or indigo! Someone making a troll cake has used all the blue-colored candies. You come in a respectable 4th place, despite your five color rainbow.

        😢 Try again.
        """,
        choices: []
    ),

    StoryPage( // 11
        """
        The judges say you overbaked your cake and your marshmallow clouds fall flat. You come in 7th place.

        😢 Try again.
        """,
        choices: []
    ),

    StoryPage( // 12
        """
        Now that the judges have moved on, you are able to get going on your decorations. You start by making all the marzipan figurines. Things are looking
        pretty good until...you SNEEZE! 🤧🦠 The spray goes everywhere and you have to restart your decorations. In the end, you run out of time and come in 8th place.

        😢 Try again.
        """,
        choices: []
    ),

    StoryPage( // 13
        """
        The judges come by to ask about your cake. They keep prying for more, and can’t understand why you are only using piped icing. After a short time,
        you realize you have missed a HUGE part of the directions. You complete the challenge and go home in last place.

        😢 Try again.
        """,
        choices: []
    ),

    StoryPage( // 14
        """
        Your cake is coming together nicely when a dog bursts into the tent! He runs through, toppling over a tray of your piped decorations. You run out
        of time to remake them and come in 9th place.

        😢 Try again.
        """,
        choices: []
    ),

    StoryPage( // 15
        """
        Your rainbow turns out magnificent! The arch is sky high and it impresses the judges. You win 2nd place.🥈

        🎉💵You are a cash prize winner!💵🥳
        """,
        choices: []
    ),

    StoryPage( // 16
        """
        Right before you get to your neighbors bench, you trip on a power cord and knock over their sponge cake! There is no time for them to start over.
        They are devastated and you decide to disqualify yourself out of solidarity.

        😢 Try again.
        """,
        choices: []
    ),

    StoryPage( // 17
        """
        Good thinking! You can complete most of your decorations while your cake continues to cool. You work hard and, before you know it, the competition is
        over and your cake looks spectacular. You come in 3rd place!🥉

        🎉💵You are a cash prize winner!💵🥳
        """,
        choices: []
    ),

    StoryPage( // 18
        """
        Oh no, you should have waited! All your frosting melts off the sides and your decorations are a disaster. Luckily your cake perfectly baked. The judges
        are pretty harsh about your decorations and you finish in 6th place.

        😢 Try again.
        """,
        choices: []
    ),

    StoryPage( // 19
        """
        The judges love your theme and the 3D elements really make it come alive! They compliment you on your mix of chocolate and marzipan. You win 1st place! 🎉🎂🥇

        🎉💵You are a cash prize winner!💵🥳
        """,
        choices: []
    ),

    StoryPage( // 20
        """
        The judges compliment your theme, but the icing is too thick and overpowers the delicate cake. You come in 5th place.

        😢 Try again.
        """,
        choices: []
    ),
])
