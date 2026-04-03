# LoongArch 架构支持模块
# 用于修复 autotools 在 LoongArch 上的兼容性问题

module OS
  module Linux
    module LoongArch
      # 更新 config.guess 和 config.sub 以支持 LoongArch
      def self.ensure_config_files_updated(buildpath)
        return unless Hardware::CPU.loongarch?

        config_files = %w[config.guess config.sub]
        config_files.each do |file|
          file_path = File.join(buildpath, file)
          if File.exist?(file_path)
            update_config_file(file_path)
          end
        end
      end

      # 更新单个配置文件
      def self.update_config_file(file_path)
        file_name = File.basename(file_path)
        gnu_config_url = "https://git.savannah.gnu.org/cgit/config.git/plain/#{file_name}"
        
        ohai "更新 #{file_name} 以支持 LoongArch"
        
        begin
          # 备份原文件
          FileUtils.cp(file_path, "#{file_path}.bak")
          
          # 下载最新的 config 文件
          system("curl", "-fsSL", "-o", file_path, gnu_config_url)
          
          # 确保文件可执行
          FileUtils.chmod(0755, file_path)
          
          ohai "#{file_name} 更新成功"
        rescue => e
          opoo "更新 #{file_name} 失败: #{e.message}"
          # 恢复备份
          FileUtils.cp("#{file_path}.bak", file_path) if File.exist?("#{file_path}.bak")
        ensure
          # 清理备份
          FileUtils.rm_f("#{file_path}.bak")
        end
      end

      # 为 Formula 提供便捷的 autotools 修复方法
      module AutotoolsFix
        def fix_autotools_config
          OS::Linux::LoongArch.ensure_config_files_updated(buildpath)
        end
      end
    end
  end
end

# 扩展 Formula 类
class Formula
  include OS::Linux::LoongArch::AutotoolsFix
end
