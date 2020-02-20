require 'json'

require 'aws-sdk-securityhub'


def update_findings_as_exception(finding_ids:)
  securityhub = Aws::SecurityHub::Client.new()

  securityhub.update_findings(
    filters: {
      id: finding_ids.map {|id|
        {
          value: id,
          comparison: "EQUALS"
        }
      }
    },
    note: {
      text: "EXCEPTION",
      updated_by: "customaction-exception"
    },
    record_state: "ARCHIVED"
  )
end


def lambda_handler(event:, context:)
  update_findings_as_exception(
    finding_ids: event["detail"]["findings"].map {|finding|
      finding["Id"]
    }
  )

  return { statusCode: 200, body: JSON.generate('OK') }
end
