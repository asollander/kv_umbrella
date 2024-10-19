defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    bucket = start_supervised!(KV.Bucket)
    %{bucket: bucket}
  end

  # test "store values by key", %{bucket: bucket} do
  test "store values by key", fullMap do
    %{bucket: bucket} = fullMap |> IO.inspect()
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "delete key", %{bucket: bucket} do
    KV.Bucket.put(bucket, "soap", 3)
    KV.Bucket.put(bucket, "toothpaste", 2)

    assert KV.Bucket.get(bucket, "soap") == 3
    assert KV.Bucket.get(bucket, "toothpaste") == 2

    assert KV.Bucket.delete(bucket, "soap") == 3
    assert KV.Bucket.get(bucket, "soap") == nil
    assert KV.Bucket.get(bucket, "toothpaste") == 2
  end

  test "are temporary workers" do
    assert Supervisor.child_spec(KV.Bucket, []).restart == :temporary
  end
end
