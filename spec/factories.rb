FactoryBot.define do
  factory :user, class: User do
    fname 'Foo'
    lname 'Bar'
    mobile '123456'
    email 'foobar@example.com'
    password 'password'
    role 'normal'
    birthdate Time.zone.today
    avatar do
      Rack::Test::UploadedFile.new(Rails.root.join('spec',
                                                   'image',
                                                   'test-image.jpg'))
    end
  end

  factory :category do
    name 'tinapay 1'
  end

  factory :product do
    name 'Pandesahl'
    description 'Ang tagalog ng verb'
    price '1234'
    image do
      Rack::Test::UploadedFile.new(Rails.root.join('spec',
                                                   'image',
                                                   'test-image.jpg'))
    end
  end

  factory :invalid_product, parent: :product do
    name nil
    description nil
    price nil
    image nil
  end

  factory :invalid_category, parent: :category do
    name nil
  end

  factory :invalid_user, parent: :user do
    fname nil
    lname nil
    mobile nil
    email nil
    password nil
    role 'normal'
    birthdate nil
    avatar nil
  end
end
