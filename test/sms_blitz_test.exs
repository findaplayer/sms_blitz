defmodule SmsBlitzTest do
  use ExUnit.Case
  doctest SmsBlitz

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "send twilio" do
    # Attempt to send the sms
    sms_receipt =
      SmsBlitz.send_sms(
        :twilio,
        from: "FAP",
        to: "+447792638416",
        message: "hi message"
      )

  end
end
