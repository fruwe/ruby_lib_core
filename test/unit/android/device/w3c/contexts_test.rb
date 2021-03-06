require 'test_helper'
require 'webmock/minitest'

# $ rake test:unit TEST=test/unit/android/device/w3c/commands_test.rb
class AppiumLibCoreTest
  module Android
    module Device
      module W3C
        class ContextsTest < Minitest::Test
          include AppiumLibCoreTest::Mock

          def setup
            @core ||= ::Appium::Core.for(Caps.android)
            @driver ||= android_mock_create_session_w3c
          end

          def test_current_context
            stub_request(:get, "#{SESSION}/context")
              .to_return(headers: HEADER, status: 200, body: { value: 'A' }.to_json)

            @driver.current_context

            assert_requested(:get, "#{SESSION}/context", times: 1)
          end

          def test_available_contexts
            stub_request(:get, "#{SESSION}/contexts")
              .to_return(headers: HEADER, status: 200, body: { value: '' }.to_json)

            @driver.available_contexts

            assert_requested(:get, "#{SESSION}/contexts", times: 1)
          end

          def test_set_context
            stub_request(:post, "#{SESSION}/context")
              .to_return(headers: HEADER, status: 200, body: { value: '' }.to_json)

            @driver.set_context 'NATIVE_APP'

            assert_requested(:post, "#{SESSION}/context", times: 1)
          end
        end # class ContextsTest
      end # module W3C
    end # module Device
  end # module Android
end # class AppiumLibCoreTest
