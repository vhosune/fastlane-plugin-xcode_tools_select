require 'fastlane/action'
require_relative '../helper/xcode_tools_select_helper'

module Fastlane
  module Actions
    class XcodeToolsSelectAction < Action
      def self.run(params)      
        required_version = params[:version]

        UI.message("Search for Xcode Command Line Tools with version: #{required_version}")
        
        # Search for Xcode paths
        output = Actions.sh_no_action("mdfind -0 'kMDItemCFBundleIdentifier = 'com.apple.dt.Xcode' && kMDItemVersion = '#{required_version}''", log: false)

        UI.user_error!("Xcode matching version `#{required_version}` not found !") unless !output.empty?

        paths = output.split("\0")
        paths.each do |line|
          UI.message("found: #{line} ")
        end

        # Select the first matching one
        xcode_path = paths.first
        xcode_tools_path = File.join(xcode_path, "/Contents/Developer")
        
        # Verify that the path exists
        UI.user_error!("Path '#{xcode_tools_path}' doesn't exist") unless Dir.exist?(xcode_tools_path)

        # Get the exact Version found
        itemVersion = Actions.sh_no_action("mdls -name 'kMDItemVersion' -raw #{xcode_path}", log: false)

        UI.message("Setting Xcode version #{itemVersion} to #{xcode_tools_path} for all build steps")
        
        ENV["DEVELOPER_DIR"] = xcode_tools_path

      end

      def self.description
        "Set the [version] of the default Xcode Command Line Tools path to use."
      end

      def self.authors
        ["Vincent HO-SUNE"]
      end

      def self.available_options
        [
           FastlaneCore::ConfigItem.new(key: :version,
                                   env_name: "XCODE_TOOLS_SELECT_VERSION",
                                description: "Version of Xcode to select",
                                   optional: false,
                                       type: String)
        ]
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
        true
      end

      def self.example_code
        [
          'xcode_tools_select(version: "10.*")'
        ]
      end

      def self.category
        :building
      end

    end
  end
end
