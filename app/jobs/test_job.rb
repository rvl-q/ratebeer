class TestJob
  include SuckerPunch::Job

  def perform
    sleep 1
    puts "starting job..."
    t = Time.now
    sleep 10
    puts t
    puts "job ready!"
    TestJob.perform_in(30.seconds)
  end
end
