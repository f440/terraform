require 'json'

require 'aws-sdk-ssm'
require 'aws-sdk-securityhub'


def run_command(resource_id:, script:)
  ssm = Aws::SSM::Client.new()

  File.open("./scripts/#{script}") do |file|
    ssm.send_command(
      document_name: "AWS-RunShellScript",
      parameters: {
        "commands" => [file.read()],
      },
      cloud_watch_output_config: {
        cloud_watch_log_group_name: ENV["CLOUDWATCH_LOG_GROUP"],
        cloud_watch_output_enabled: true
      },
      # TODO: 必要ならS3にもログ出力する
      # output_s3_bucket_name: "S3BucketName",
      # output_s3_key_prefix: "S3KeyPrefix",
      instance_ids: [resource_id.split("/")[-1]]
    )
  end
end


def update_finding_as_archived(finding_id:)
  securityhub = Aws::SecurityHub::Client.new()

  securityhub.update_findings(
    filters: {
      id: [
        {
          value: finding_id,
          comparison: "EQUALS"
        }
      ]
    },
    record_state: "ARCHIVED"
  )
end


def lambda_handler(event:, context:)
  finding_type_script_map = {
    "Software and Configuration Checks/AWS Security Best Practices/Disable root login over SSH" =>
      "disable_root_ssh.sh",
    "Software and Configuration Checks/Disable root login over SSH with a command authenticated by public key" =>
      "disable_root_ssh.sh"
  }

  event["detail"]["findings"].each do |finding|
    finding["Types"].each do |finding_type|
      if finding_type_script_map[finding_type].nil? then
        raise "No script for #{finding_type}"
      end

      finding["Resources"].each do |resource|
        run_command(resource_id: resource["Id"], script: "disable_root_ssh.sh")
        update_finding_as_archived(finding_id: finding["Id"])
      end
    end
  end 

  return { statusCode: 200, body: JSON.generate('OK') }
end
