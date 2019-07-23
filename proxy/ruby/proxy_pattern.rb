=begin
According to the GoF, the intent of the Proxy pattern is to:

"Provide a surrogate or placeholder for another object to control access to it."
=end

class BankAccount
  def balance; end
  def deposit(amount); end
  def withdraw(amount); end
end

class BankAccountProxy
  def balance; subject.balance; end
  def deposit(amount); subject.deposit(amount); end
  def withdraw(amount); subject.withdraw(amount); end

  private

  @subject ||= BankAccount.new
end
