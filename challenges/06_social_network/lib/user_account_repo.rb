require 'user_account'

class UserAccountRepository
  def all
    sql = 'SELECT * FROM user_accounts;'
    result = DatabaseConnection.exec_params(sql, [])
    result.map { |record| make_user(record) }
  end

  def find(id)
    sql = 'SELECT * FROM user_accounts WHERE id = $1'
    result = DatabaseConnection.exec_params(sql, [id])
    result.map { |record| make_user(record) }
  end

  def create(user_account)
    sql = 'INSERT INTO user_accounts (email_address, username) VALUES ($1, $2)'
    params = [user_account.email_address, user_account.username]
    DatabaseConnection.exec_params(sql, params)
  end

  def update(id, user_account)
    sql = 'UPDATE user_accounts SET (email_address, username) = ($1, $2) WHERE id = $3'
    params = [user_account.email_address, user_account.username, id]
    DatabaseConnection.exec_params(sql, params)
  end

  def delete(id)
    sql = 'DELETE FROM user_accounts WHERE id = $1'
    DatabaseConnection.exec_params(sql, [id])
  end

  private

  def make_user(record)
    user = UserAccount.new
    user.id = record['id']
    user.email_address = record['email_address']
    user.username = record['username']
    user
  end
end