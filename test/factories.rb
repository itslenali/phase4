FactoryBot.define do
 
  factory :employee do
    first_name { "Ed" }
    last_name { "Gruberman" }
    ssn { rand(9 ** 9).to_s.rjust(9,'0') }
    date_of_birth { 19.years.ago.to_date }
    phone { rand(10 ** 10).to_s.rjust(10,'0') }
    role { "employee" }
    active { true }
  end
  
  factory :store do
    name {"CMU"}
    street {"5000 Forbes Avenue"}
    city {"Pittsburgh"}
    state {"PA"}
    zip {"15213"}
    phone { rand(10 ** 10).to_s.rjust(10,'0') }
    active {true}
  end
  
  factory :assignment do
    association :store
    association :employee
    start_date {1.year.ago.to_date}
    end_date {1.month.ago.to_date}
    pay_level {1}
  end
  
  factory :flavor do
    name {"Vanilla"}
    active {true}
  end
  
  factory :store_flavor do
    association :store
    association :flavor
  end
  
  factory :shift do
    association :assignment
    date {Date.today}
    start_time {Time.current}
    end_time {"9:59".to_time}
    notes {"This shift experienced lots of customers"}
  end
  
  factory :job do
    name {"Scooping ice cream"}
    description {"Includes making milkshakes"}
    active {true}
  end
  
  factory :shift_job do
    association :shift
    association :job
  end
  
  factory :user do
    association :employee
    email {"alexheimann@amcreamery.com"}
    password_digest {"hello"}
    #employee_id {1}
  end
end