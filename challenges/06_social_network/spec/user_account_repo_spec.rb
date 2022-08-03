require 'user_account_repo'

def reset_user_accounts_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network' })
  connection.exec(seed_sql)
end

describe UserAccountRepository do
  before(:each) do 
    reset_user_accounts_table
  end

  it "gets all user_accounts" do
    repo = UserAccountRepository.new

    user_accounts = repo.all
    
    expect(user_accounts.length).to eq 2
    
    expect(user_accounts[0].id).to eq '1'
    expect(user_accounts[0].email_address).to eq 'homer@simpsons.com'
    expect(user_accounts[0].username).to eq 'Homer Simpson'
    
    expect(user_accounts[1].id).to eq '2'
    expect(user_accounts[1].email_address).to eq 'bart@simpsons.com'
    expect(user_accounts[1].username).to eq 'Bart Simpson'
  end
end