FactoryBot.define do
  factory :user do
    nickname              {"abe"}
    email                 {"aaa@gmail.com"}
    password              {"0000abc"}
    password_confirmation {password}
    family_name           {"鈴木"}
    first_name            {"太郎"}
    family_name_furigana  {"スズキ"}
    first_name_furigana   {"タロウ"}
    birthday              {"1992-01-01"}
  end
end
