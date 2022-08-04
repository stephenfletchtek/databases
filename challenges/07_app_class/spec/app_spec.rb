require_relative '../app.rb'

def reset_albums_table
  seed_sql = File.read('spec/seeds_app.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

RSpec.describe Application do
  before(:each) do
    reset_albums_table
  end
  
  it "runs" do
    album_list = [
      "* 1 - Doolittle",
      "* 2 - Surfer Rosa",
      "* 3 - Waterloo",
      "* 4 - Super Trouper",
      "* 5 - Bossanova",
      "* 6 - Lover",
      "* 7 - Folklore",
      "* 8 - I Put a Spell on You",
      "* 9 - Baltimore",
      "* 10 - Here Comes the Sun",
      "* 11 - Fodder on My Wings",
      "* 12 - Ring Ring"
    ]

    artist_list = [
      "* 1 - Pixies",
      "* 2 - ABBA",
      "* 3 - Taylor Swift",
      "* 4 - Nina Simone"
    ]

    io = double :fake
    expect(io).to receive(:puts).with("Enter your choice:")
    expect(io).to receive(:gets).and_return("1")
    expect(io).to receive(:puts).with("Here is the list of albums:")
    album_list.each do |album|
      expect(io).to receive(:puts).with(album)
    end

    expect(io).to receive(:puts).with("Enter your choice:")
    expect(io).to receive(:gets).and_return("2")
    expect(io).to receive(:puts).with("Here is the list of artists:")
    artist_list.each do |artist|
      expect(io).to receive(:puts).with(artist)
    end

    expect(io).to receive(:puts).with("Enter your choice:")
    expect(io).to receive(:gets).and_return("3")
    expect(io).to receive(:puts).with("Choice not recognised")

    app = Application.new(
      'music_library_test', 
      io, 
      AlbumRepository.new, 
      ArtistRepository.new
    )

    3.times { app.run }
  end
end