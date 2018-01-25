FactoryBot.define do
  factory :user, class: User do
    fname "Kent"
    lname "Derrick"
    password "foobar"
    email "kent@yahoo.com"
    avatar do
      Rack::Test::UploadedFile.new(Rails.root.join('spec',
                                                   'support',
                                                   'images',
                                                   'test_user.jpeg'))
    end
    birthdate "01/12/1998"
    mobile "09493622891"
    role 0
  end

  factory :admin, class: User do
    fname "Admin"
    lname "Mo"
    password "foobar"
    email "admiral@yahoo.com"
    avatar do
      Rack::Test::UploadedFile.new(Rails.root.join('spec',
                                                   'support',
                                                   'images',
                                                   'test_user.jpeg'))
    end
    birthdate "01/12/1998"
    mobile "09493622891"
    role 1
  end

  factory :invalid_user, class: User do
    fname "Kent"
    lname "Derrick"
    password "foobar"
    email "kent.com"
    avatar nil
    birthdate "01/12/1998"
    mobile "qwe"
    role 0
  end

  factory :invalid_category, class: Category do
    name nil
  end

  factory :category, class: Category do
    name "Bags"
  end

  factory :product, class: Product do
    association :user
    association :category
    name "Backpack ni Dora"
    description "Okay to"
    price 250.00
    image {
      Rack::Test::UploadedFile.new(Rails.root.join('spec',
                                                   'support',
                                                   'images',
                                                   'test_user.jpeg'))
    }
  end

  factory :invalid_product, class: Product do
    association :user
    association :category
    name nil
    description "Okay to"
    price 250.00
    image nil
  end
end
