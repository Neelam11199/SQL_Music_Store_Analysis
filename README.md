# SQL_Music_Store_Analysis
"The Music Store Story"

Imagine you're working for an online music store. Here's how the system is organized:

👥 People
Customers come to the store to buy music.

Each customer is helped by a Support Rep (an Employee).

Employees also have managers, which is shown through a self-join in the Employee table.

💽 Music Organization
Artists create albums.

Each album contains tracks (songs).

Every track belongs to a genre and is in a certain media type (like MP3, WAV, etc.).

🎶 Playlists
Customers can create playlists.

A playlist can have many tracks, and each track can be in many playlists.

This is a many-to-many relationship, handled by the PlaylistTrack table.

🧾 Sales
When a customer buys music, an Invoice is created.

Each invoice has one or more InvoiceLine entries – each line represents a track the customer bought.

So the flow is:
Customer → Invoice → InvoiceLine → Track
