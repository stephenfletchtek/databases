require 'album_repository'

RSpec.describe AlbumRepository do
  def reset_album_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_album_table
  end

  it "returns all albums" do
    repo = AlbumRepository.new
    albums = repo.all
    expect(albums.length).to eq 12
    expect(albums[0].id).to eq '1'
    expect(albums[0].title).to eq 'Doolittle'
    expect(albums[0].release_year).to eq '1989'
  end

  it "gets a single album" do
    repo = AlbumRepository.new
    album = repo.find(2)
    expect(album.id).to eq "2"
    expect(album.title).to eq 'Surfer Rosa'
    expect(album.release_year).to eq "1988"
    expect(album.artist_id).to eq "1"
  end

  it "creates an album" do
    repo = AlbumRepository.new
    repo.create('Revolver', 1966, 5)
    albums = repo.all
    expect(albums.length).to eq 13
    expect(albums.last.id).to eq "13"
    expect(albums.last.title).to eq "Revolver"
    expect(albums.last.release_year).to eq "1966"
    expect(albums.last.artist_id).to eq "5"
  end

  it "Updates an album" do
    repo = AlbumRepository.new
    repo.update(1, "release_year", 2000)
    album = repo.find(1)
    expect(album.release_year).to eq "2000"
  end

  it "Deletes an album" do
    repo = AlbumRepository.new
    repo.delete(1)
    albums = repo.all
    expect(albums.length).to eq 11
    expect { repo.find(1) }.to raise_error IndexError
  end
end