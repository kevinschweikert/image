defmodule Image.QRcode.Test do
  use ExUnit.Case, async: true
  import Image.TestSupport

  test "QR code detection and decoding" do
    {:ok, image} = Image.open image_path("qr_code_con.png")

    assert Image.QRcode.decode(image) == {:ok, "MECARD:N:Joe;EMAIL:Joe@bloggs.com;;"}
  end

  test "QR code detection fails unless the image has three bands" do
    {:ok, image} = Image.open image_path("qrcode_orig.png")

    assert Image.QRcode.decode(image) ==
      {:error,
         "Only images with three bands can be transferred to eVision. Found an image of shape {440, 440, 2}"}
  end

  test "QR code detection when there is no qrcode in the image" do
    {:ok, image} = Image.open image_path("Kip_small.png")

    assert Image.QRcode.decode(image) == {:error, "No QRcode detected in the image"}
  end
end