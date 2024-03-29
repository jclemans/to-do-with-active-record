require 'spec_helper'

describe Task do
  it 'returns the not done tasks' do
    not_done_tasks = (1..2).to_a.map { |number| Task.create(name: "task #{number}", done: false)}
    done_task = Task.create({name: "done task", done: true})
    Task.not_done.should eq not_done_tasks
  end
  it { should belong_to :list }
end
