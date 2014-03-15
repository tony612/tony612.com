FactoryGirl.define do
  factory :post do
    sequence :title do |n|
      "Post title #{n}"
    end
    sequence :content do |n|
      "Post content #{n}"
    end
    category "tech"
    excerpt  "Post Excerpt"
  end
end
