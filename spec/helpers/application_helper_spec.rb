require 'spec_helper'

module MortgageCalculator
  describe ApplicationHelper do
    describe :zendesk_stamp_duty_config do
      it 'loads correct config' do
        config = helper.zendesk_stamp_duty_config

        expect(config[:en]).to eql({"id"=>"20289328", "url"=>"https://mastest.zendesk.com", "name" => "Feedback"})
        expect(config[:cy]).to eql({"id"=>"20281613", "url"=>"https://mastest.zendesk.com", "name" => "Adborth"})
      end
    end
  end
end
