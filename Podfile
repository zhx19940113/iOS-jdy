# Uncomment this line to define a global platform for your project
# platform :ios, ‘7.0’

source 'https://github.com/CocoaPods/Specs.git'

post_install do |installer_representation|
    installer_representation.project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
        end
    end
end

target 'licai' do
pod 'SBJson',        '~> 3.2'
pod 'AFNetworking', '~> 2.3.1'
pod 'RegexKitLite', '~> 4.0'
pod 'MBProgressHUD', '~> 0.8'
pod 'MYIntroduction', '~> 0.0.1'
pod 'FMDB', '~> 2.3'
pod 'IQKeyboardManager'
pod 'GCDiscreetNotificationView', '~> 1.0.2'
pod 'pop', '~> 1.0.5'
pod 'PEPhotoCropEditor'
pod 'ImagePlayerView'
pod 'SWTableViewCell'
end


