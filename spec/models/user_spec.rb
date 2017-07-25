require 'rails_helper'

RSpec.describe User, type: :model do
  describe User do
    it { should have_valid(:first_name).when('Arya', 'Tyrion') }
    it { should_not have_valid(:first_name).when('', nil) }

    it { should have_valid(:last_name).when('Stark', 'Lannister') }
    it { should_not have_valid(:last_name).when('', nil) }

    it { should have_valid(:email).when('arya@winterfell.com', 'tyrion@got.com') }
    it { should_not have_valid(:email).when('', nil, 'asdjk', 'asdg.com', 'asdadk@') }

    it { should have_valid(:role).when("admin", "member") }
    it { should_not have_valid(:role).when(nil, 1)}

    it { should have_valid(:profile_photo).when('www.google.com/picture.jpg') }
  end
end
