require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class XcodeToolsSelectHelper
      # class methods that you define here become available in your action
      # as `Helper::XcodeToolsSelectHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the xcode_tools_select plugin helper!")
      end
    end
  end
end
