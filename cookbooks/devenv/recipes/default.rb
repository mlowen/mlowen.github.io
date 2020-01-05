package 'gpgv2'
package 'git'

# Ruby
execute 'curl -sSL https://rvm.io/mpapis.asc | gpg --import -'
execute 'curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -'
execute 'curl -sSL https://raw.githubusercontent.com/rvm/rvm/stable/binscripts/rvm-installer | bash -s stable --ruby=2.6.3 --gems=foreman'

group 'rvm' do
  action :manage
  members ['vagrant']
end
