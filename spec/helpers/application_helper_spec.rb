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

    describe :no_follow? do
      context 'when tool is not syndicated' do
        before :each do
          controller.stub(:syndicated_tool_request?).and_return{ false }
        end

        it 'returns false' do
          expect(helper.no_follow?).to be_false
        end
      end

      context 'when tool is syndicated' do
        before :each do
          controller.stub(:syndicated_tool_request?).and_return{ true }
        end

        it 'returns nofollow' do
          expect(helper.no_follow?).to eql("nofollow")
        end
      end
    end
  end
end
