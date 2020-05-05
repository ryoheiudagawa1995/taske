require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :Deletion
RSpec.describe 'タスク管理機能', type: :system do
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        task = FactoryBot.create(:task, task_name: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        fill_in 'Task name', with: 'タスク'
        fill_in 'Limit', with: '2020.05.30'
        click_on 'Create Task'
        expect(page).to have_content 'limit', '2020.05.30'
      end

    end
  end
  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移する' do
         DatabaseCleaner.clean
         task = FactoryBot.create(:task, task_name: 'task')
         visit tasks_path
         click_on 'Show'
         expect(page).to have_content 'task_name', 'task'
       end
     end
  end
end
