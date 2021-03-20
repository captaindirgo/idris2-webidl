// Extracted from https://w3c.github.io/clipboard-apis/

dictionary ClipboardEventInit : EventInit {
  DataTransfer? clipboardData = null;
};

[Exposed=Window]
interface ClipboardEvent : Event {
  constructor(DOMString type, optional ClipboardEventInit eventInitDict = {});
  readonly attribute DataTransfer? clipboardData;
};

partial interface Navigator {
  [SecureContext, SameObject] readonly attribute Clipboard clipboard;
};

typedef sequence<ClipboardItem> ClipboardItems;

[SecureContext, Exposed=Window] interface Clipboard : EventTarget {
  Promise<ClipboardItems> read();
  Promise<DOMString> readText();
  Promise<undefined> write(ClipboardItems data);
  Promise<undefined> writeText(DOMString data);
};

typedef (DOMString or Blob) ClipboardItemDataType;
typedef Promise<ClipboardItemDataType> ClipboardItemData;

callback ClipboardItemDelayedCallback = ClipboardItemData ();

[Exposed=Window] interface ClipboardItem {
  constructor(record<DOMString, ClipboardItemData> items,
    optional ClipboardItemOptions options = {});
  static ClipboardItem createDelayed(
      record<DOMString, ClipboardItemDelayedCallback> items,
      optional ClipboardItemOptions options = {});

  readonly attribute PresentationStyle presentationStyle;
  readonly attribute long long lastModified;
  readonly attribute boolean delayed;

  readonly attribute FrozenArray<DOMString> types;

  Promise<Blob> getType(DOMString type);
};

enum PresentationStyle { "unspecified", "inline", "attachment" };

dictionary ClipboardItemOptions {
  PresentationStyle presentationStyle = "unspecified";
};

dictionary ClipboardPermissionDescriptor : PermissionDescriptor {
  boolean allowWithoutGesture = false;
};
