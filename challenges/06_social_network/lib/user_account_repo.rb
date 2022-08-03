require 'user_account'

class UserAccountRepository
  def all
    sql = 'SELECT * FROM user_accounts;'
    result = DatabaseConnection.exec_params(sql, [])
    result.map { |record| make_user(record) }
  end

  private

  def make_user(record)
    user = UserAccount.new
    user.id = record ['id']
    user.email_address = record['email_address']
    user.username = record['username']
    user
  end
end