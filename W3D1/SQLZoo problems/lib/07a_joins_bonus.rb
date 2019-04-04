# == Schema Information
#
# Table name: albums
#
#  asin        :string       not null, primary key
#  title       :string
#  artist      :string
#  price       :float
#  rdate       :date
#  label       :string
#  rank        :integer
#
# Table name: styles
#
# album        :string       not null
# style        :string       not null
#
# Table name: tracks
# album        :string       not null
# disk         :integer      not null
# posn         :integer      not null
# song         :string

require_relative './sqlzoo.rb'

def alison_artist
  # Select the name of the artist who recorded the song 'Alison'.
  execute(<<-SQL)
    SELECT albums.artist
    FROM albums
    JOIN tracks ON tracks.album = albums.asin
    WHERE tracks.song = 'Alison'
  SQL
end

def exodus_artist
  # Select the name of the artist who recorded the song 'Exodus'.
  execute(<<-SQL)
  SELECT albums.artist
  FROM albums
  JOIN tracks ON tracks.album = albums.asin
  WHERE tracks.song = 'Exodus'
  SQL
end

def blur_songs
  # Select the `song` for each `track` on the album `Blur`.
  execute(<<-SQL)
  SELECT tracks.song
  FROM tracks
  JOIN albums ON albums.asin = tracks.album
  WHERE albums.title = 'Blur'
  SQL
end

def heart_tracks
  # For each album show the title and the total number of tracks containing
  # the word 'Heart' (albums with no such tracks need not be shown). Order first by
  # the number of such tracks, then by album title.
  # oh wow this shit *is* case sensitive hmm
  execute(<<-SQL)
  SELECT
    albums.title, COUNT(tracks.song)
  FROM
    albums
  JOIN
    tracks ON tracks.album = albums.asin
  WHERE tracks.song LIKE '%Heart%'
  GROUP BY
    albums.title
  ORDER BY COUNT(tracks.song) DESC, albums.title
  SQL
end

def title_tracks
  # A 'title track' has a `song` that is the same as its album's `title`. Select
  # the names of all the title tracks.
  # weird it didn't work the first time but it did now hmm
  execute(<<-SQL)
  SELECT
    tracks.song
  FROM
    tracks
  JOIN
    albums ON albums.asin = tracks.album
  WHERE
    albums.title = tracks.song
  SQL
end

def eponymous_albums
  # An 'eponymous album' has a `title` that is the same as its recording
  # artist's name. Select the titles of all the eponymous albums.
  execute(<<-SQL)
  SELECT
    albums.title
  FROM
    albums
  WHERE
    albums.title = albums.artist
  SQL
end

def song_title_counts
  # Select the song names that appear on more than two albums. Also select the
  # COUNT of times they show up.
  # oh my god you got it you can COUNT(DISTINCT ) can't believe you actually remember and retain this stuff so well so lucky yes group by songs then count distinct albums in those groupings so great
  execute(<<-SQL)
    SELECT
      tracks.song, COUNT(DISTINCT albums.asin) AS appearances
    FROM
      tracks
    JOIN
      albums ON albums.asin = tracks.album
    GROUP BY
      tracks.song
    HAVING
      COUNT(DISTINCT albums.asin) > 2
  SQL
end

def best_value
  # A "good value" album is one where the price per track is less than 50
  # pence. Find the good value albums - show the title, the price and the number
  # of tracks.
  # killed it one shot really get this stuff super lucky to have it coalesce so well even having not practiced it man you do need to get sleep though ugh
  execute(<<-SQL)
    SELECT
      albums.title, albums.price, COUNT(tracks.song) AS num_tracks
    FROM
      albums
    JOIN
      tracks ON tracks.album = albums.asin
    GROUP BY
      albums.asin
    HAVING
      (albums.price/COUNT(tracks.song)) < 0.5
  SQL
end

def top_track_counts
  # Wagner's Ring cycle has an imposing 173 tracks, Bing Crosby clocks up 101
  # tracks. List the top 10 albums. Select both the album title and the track
  # count, and order by both track count and title (descending).
  # the general rule seems to be you can group by a primary key and select other things
  # as long as those things are 1:1 with the primary key very interesting try grouping by something else too
  # yep nope you can only group by the primary key and then select other things that are 1:1 with it super fascinating
  # killed it one shot so lucky to be smart and to just remember these man
  # get enough sleep man so lucky to be awake and have gotten so much sleep but also not great to stay up now for sure
  execute(<<-SQL)
    SELECT
      albums.title, COUNT(tracks.song) AS track_count
    FROM
      albums
    JOIN
      tracks ON tracks.album = albums.asin
    GROUP BY
      albums.asin
    ORDER BY
      COUNT(tracks.song) DESC, albums.title DESC
    LIMIT 10
  SQL
end

def rock_superstars
  # Select the artist who has recorded the most rock albums, as well as the
  # number of albums. HINT: use LIKE '%Rock%' in your query.
  # interesting that you needed to use DISTINCT here I wonder why ooh I see
  # the albums were listed multiple times because there are multiple styles for each album
  # that's why it would be a separate table of an album has_many styles and multiple
  # albums are listed multiple times with different kinds of rock styles dope
  execute(<<-SQL)
    SELECT
      albums.artist, COUNT(DISTINCT albums.asin)
    FROM
      albums
    JOIN
      styles ON styles.album = albums.asin
    WHERE
      styles.style LIKE '%Rock%'
    GROUP BY
      albums.artist
    ORDER BY
      COUNT(DISTINCT albums.asin) DESC
    LIMIT 1
  SQL
end

def expensive_tastes
  # Select the five styles of music with the highest average price per track,
  # along with the price per track. One or more of each aggregate functions,
  # subqueries, and joins will be required.
  #
  # HINT: Start by getting the number of tracks per album. You can do this in a
  # subquery. Next, JOIN the styles table to this result and use aggregates to
  # determine the average price per track. oh fuck it not necessary lol
  execute(<<-SQL)
    SELECT
      COUNT(tracks.song)
    FROM
      tracks
    JOIN
      albums ON albums.asin = tracks.album
    JOIN
      styles ON styles.album = albums.asin
    GROUP BY
      styles.asin
  SQL
end


    # Incorrect first attempt hmm
    # SELECT
    #   styles.style, (SUM(albums.price)/COUNT(tracks.song)) AS price_per_track
    # FROM
    #   styles
    # JOIN
    #   albums ON albums.asin = styles.album
    # JOIN
    #   tracks ON tracks.album = albums.asin
    # GROUP BY
    #   styles.style
    # ORDER BY
    #   (SUM(albums.price)/COUNT(tracks.song)) DESC
    # LIMIT 5