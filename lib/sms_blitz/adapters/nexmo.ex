defmodule SmsBlitz.Adapters.Nexmo do

  @base_uri "https://rest.nexmo.com/sms/json"

  def authenticate({key, secret}) do
    %{
      uri:  @base_uri,
      auth: %{
        key:    key,
        secret: secret
      }
    }
  end

  def send_sms(%{uri: uri, auth: %{key: key, secret: secret}}, from: from, to: to, message: message) when is_binary(from) and is_binary(to) and is_binary(message) do
    body = %{
      from:       from,
      to:         to,
      text:       message,
      api_key:    key,
      api_secret: secret
    } |> Poison.encode!

    {:ok, %{headers: headers, body: resp, status_code: _status_code}} = HTTPoison.post(
      uri,
      body,
      [{"Content-Type", "application/json"}]
    )

    {:ok, %{"message-count" => _msg_count, "messages" => [response_status]}} = Poison.decode(resp)

    if response_status["status"] == "0" do
      %{
        id:            response_status["message-id"],
        result_string: "success",
        status_code:   response_status["status"]
      }
    else

      {_key, trace_id} = Enum.find(headers, fn
          ({"X-Nexmo-Trace-Id", _value}) -> true
          (_)                            -> false
        end)

      %{
        id: trace_id,
        result_string: response_status["error-text"],
        status_code:   response_status["status"]
      }
    end
  end
end
