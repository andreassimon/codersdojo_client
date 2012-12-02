# encoding: utf-8

require 'flote/scheduler'


describe Scheduler do

  it 'forwards the interrupt to the registered interrupt listener' do
    runner = mock 'runner', :start => nil, :execute => nil
    interrupt_listener = mock 'interrupt_listener'
    scheduler = Scheduler.new runner
    scheduler.interrupt_listener = interrupt_listener


    interrupt_listener.should_receive(:interrupt).with no_args

    child_pid = fork do
      puts interrupt_listener
      scheduler.start
    end
    puts interrupt_listener
    Process.kill "INT", child_pid
    Process.wait child_pid
  end

end
