# TweeTone

# Inspiration
Every day, people all around the world post their thoughts on Twitter. Being such a pervasive platform, Twitter provides a space where millions of users can express their views and thoughts about almost anything. With everything that's going on in the world today, it's important to stay connected to those in our extended community. Why not harness and analyze the immense quantity of real user data found in everyday tweets? With this in mind, we created TweeTone, a fun tool that allows users to connect to our global community through music.

# What it does
TweeTone aggregates a sample of tweets from around the world and analyzes the text body across these tweets to generate a general world mood. From there, it provides the user with a Spotify playlist that reflects how the world is feeling at the time!

# How we built it
We built it using Swift, JSON, TwitterKit, and also experimented with the Watson API.

# Challenges we ran into
We were unfamiliar with the Twitter API so we ran into some challenges trying to access and filter tweet data. The Watson API was something none of us had worked with as well. Once we worked through that, we had to create an intuitive UI for the Twitter feed and ran into some problems with constraints. Throughout the way we had to work through a lot of merge conflicts.

# Accomplishments that we're proud of
Our team had never used TwitterKit before, so we're proud to have been able to access and analyze real tweet data, collecting a sample of data, and then parsing through the text bodies. We also successfully analyzed joy and sadness from the sample of tweets. About half the team was relatively new to iOS development, so we got to learn how Swift and the UI components of mobile applications work. Some of us didn't really understand how swift worked, and all of us were new to the APIs.

# What we learned
We learned how to create an iOS app from start to finish, designing UI components and implementing back end code. We got to explore TwitterKit and looked into other interesting APIs. We worked collaboratively as a team and pushed to challenge ourselves to work through issues. We also learned how the Watson API worked and how it could be used to do sentiment analysis.

# What's next for TweeTone
To gain a better assessment of what's going on in the world, we plan to filter our sample set of data to perhaps ignore spam tweets or focus only on popular tweets. We hope to add more functions including increased user interaction with the tweets themselves, like to be able to like or post tweets from within the app. We also will improve upon our analysis of the tweet body for more in-depth sentiment analysis. Finally, we plan to polish our UI for smoother user experience.
