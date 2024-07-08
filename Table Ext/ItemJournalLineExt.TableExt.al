tableextension 90502 "Item Journal Line Ext" extends "Item Journal Line"
{
    fields
    {
        field(90500; "Custom Field 1"; Code[20])
        {
            Caption = '"Custom Field 1"';
            DataClassification = CustomerContent;
        }
        field(90501; "Custom Field 2"; Integer)
        {
            Caption = 'Custom Field 2';
            DataClassification = CustomerContent;
        }
    }
}
