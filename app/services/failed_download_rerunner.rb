class FailedDownloadRerunner
    attr_reader :count, :fetcher
    def initialize(count = 0)
        @count = count
        @fetcher = AntennaSearchFetcher.new(0, 0)
    end

    def run!
        FailedDownload.still_failed.
                       where('reran_count < ?', count).
                       or(FailedDownload.where(reran_count: nil)).each do |fd|

            fetcher.lat = fd.lat
            fetcher.lng = fd.lng
            if SuccesfulDownload.where(lat: fd.lat, lng: fd.lng).present?
                fd.update(reran_successfully: true)
                next
            end
            fetcher.fetch!
            fd.update(reran_count: fd.reran_count ? fd.reran_count + 1 : 1)
        end 
    end 
end 