class SendCampaignSummaryJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    campaign = args[0]

    puts ">>>>>>>>>>>>>> Sending Campaign Summary for #{campaign.title}"

    # It is possible to have a job set up the next job instead of depending on a CRON job, but if a job fails, you will need to fix the error before jobs can be scheduled again

    # Alternatively, set up a rescue loop
    # begin
    #   # attempt to send the summary
    # rescue
    #   # let admin know to fix bug
    # ensure
    #   # schedule the next one regardless
        # SendCampaignSummaryJob.set(wait_until: Time.now + 1.hour).perform_later(campaign)
    # end
  end
end
