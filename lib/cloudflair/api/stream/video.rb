# frozen_string_literal: true

require 'cloudflair/entity'

module Cloudflair
  module Stream
    class Video < Cloudflair::Stream::Base
      include Cloudflair::Entity

      attr_reader :account_id
      attr_reader :video_id

      path 'accounts/:account_id/stream'

      def initialize(account_id, video_id=nil)
        @account_id = account_id
        @video_id = video_id
      end

      # https://api.cloudflare.com/#stream-videos-upload-a-video-from-a-url
      def copy(url, additional_options = {})
        params = { url: url }
        params.merge(additional_options)
        res = response connection.post("#{path}/copy", params)
        @video_id = res&.result&.uid
        res
      end

      def details
        raise Cloudflair::CloudflairError, "video_id must not be nil for this request" if @video_id.nil?
        response connection.get("#{path}/#{@video_id}")
      end

      def generate_token(params={})
        raise Cloudflair::CloudflairError, "video_id must not be nil for this request" if @video_id.nil?
        response connection.post("#{path}/#{@video_id}/token", params)
      end
    end
  end
end
