# package 'gpgv2'

# Ruby
execute 'curl -sSL https://rvm.io/mpapis.asc | gpg --import -'
execute 'curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -'
execute 'curl -sSL https://raw.githubusercontent.com/rvm/rvm/stable/binscripts/rvm-installer | bash -s stable --ruby=2.6.3'

group 'rvm' do
  action :manage
  members ['vagrant']
end
