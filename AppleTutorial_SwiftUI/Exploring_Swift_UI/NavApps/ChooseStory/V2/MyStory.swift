/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

let story = Story(pages: [
    StoryPage( // 0
        """
        Welcome to Choose Your Own Story
        🥖🍪Bake Off!🥐🍰
        
        You enter a local baking competition at the county fair 🎪. It’s a beautiful summer day and you are excited! When you enter the room, you look around to see ten identical stations.
        
        Each station is stocked with bowls of different sizes, spatulas, spoons, and a standing mixer. You are the third to arrive, so there are many stations still available. Where do you sit?
        """,
        choices: [
            Choice(text: "Front row!", destination: 1),
            Choice(text: "Find somewhere in the middle", destination: 1),
            Choice(text: "Back of the room", destination: 2),
        ]
    ),
    StoryPage( // 1
        """
        Luckily, some nice people fill in around you and wave politely. The directions sounds fun! Make a sponge cake you would have wanted as a child for your birthday, focusing on the decorations and theme. The top three bakers will win a cash prize. You start with a theme.
        """,
        choices: [
            Choice(text: "Trains", destination: 3),
            Choice(text: "Castles", destination: 5),
            Choice(text: "Rainbows", destination: 6),
            Choice(text: "Woodland creatures", destination: 5),
            Choice(text: "Outer space", destination: 3),
        ]
    ),
    StoryPage( // 2
        """
        Oh no. There is a very loud person next to you. You can barely hear the directions in the back of the room. You think they said something about a birthday cake. Luckily, the person in front of you whispers a brief review of what they said...glazing over a few things. “A birthday cake I would have wanted as a kid.” Hmm? You think back to your favorite cake.
        """,
        choices: [
            Choice(text: "Chocolate", destination: 4),
            Choice(text: "Red velvet", destination: 4),
            Choice(text: "Vanilla confetti", destination: 5),
            Choice(text: "Strawberry shortcake", destination: 3),
        ]
    ),
    StoryPage( // 3
        """
        Great choice! Now you just need to make the sponge cake and start thinking about the toppings. You scan the selection on the table and start planning your toppings. In addition to all the colorful icing, you choose...
        """,
        choices: [
            Choice(text: "Sprinkles", destination: 8),
            Choice(text: "Berries", destination: 7),
            Choice(text: "Chocolate", destination: 9),
        ]
    ),
    StoryPage( // 4
        """
        Okay, you seem to be in the clear. Everyone else is busy working on their cakes and you are too...only their cakes all look the same. You shrug it off thinking your cake is going to be unique and special. The judges come over and ask you what’s going to go on top of your cake. You tell them:
        """,
        choices: [
            Choice(text: "Piped buttercream frosting", destination: 13),
            Choice(text: "Fondant icing", destination: 7),
        ]
    ),
    StoryPage( // 5
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
        There is so much available to decorate with; your cake keeps getting better and better. You notice some of your neighbors are using some decorations you didn’t see on the table. What do you do?
        """,
        choices: [
            Choice(text: "Pop over to your neighbor’s bench and ask where they got their toppings.", destination: 16),
            Choice(text: "Keep working away, your cake will be great even without the specialty item.", destination: 20),
        ]
    ),
    StoryPage( // 8
        """
        You are running out of time, so you put your cake in the freezer to speed things up. You check it after ten minutes. What do you do?
