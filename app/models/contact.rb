class Contact
  include ActiveModel::Model

  attr_accessor :email, :message

  validates :email,  length: { minimum: 3, :too_short => 'メールアドレスを入力して下さい。'}
  validates :message, :presence => { :message => '問い合わせ内容を入力して下さい。'}
end