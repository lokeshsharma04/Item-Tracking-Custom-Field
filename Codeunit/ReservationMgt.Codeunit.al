codeunit 90500 "Reservation Mgt."
{

    var

    Var
        VarCustomField1: Code[20];
        VarCustomField2: Decimal;
        ModifyRun: Boolean;

    //Update custom field values For New Insert value Updated in Reservation Entry
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterChangeOnChangeTypeInsertOnBeforeInsertReservEntry', '', false, false)]
    local procedure OnRegisterChangeOnChangeTypeInsertOnBeforeInsertReservEntry(var OldTrackingSpecification: Record "Tracking Specification"; var NewTrackingSpecification: Record "Tracking Specification")
    Begin
        ModifyRun := false;
        VarCustomField1 := NewTrackingSpecification."Custom Field 1";
        VarCustomField2 := NewTrackingSpecification."Custom Field 2";
    End;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", 'OnAfterSetDates', '', false, false)]
    local procedure OnAfterSetDates(var ReservationEntry: Record "Reservation Entry")
    Begin
        ReservationEntry."Custom Field 1" := VarCustomField1;
        ReservationEntry."Custom Field 2" := VarCustomField2;
    End;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", 'OnCreateReservEntryExtraFields', '', false, false)]
    local procedure OnCreateReservEntryExtraFields(var InsertReservEntry: Record "Reservation Entry"; OldTrackingSpecification: Record "Tracking Specification"; NewTrackingSpecification: Record "Tracking Specification")
    Begin
        InsertReservEntry."Custom Field 1" := NewTrackingSpecification."Custom Field 1";
        InsertReservEntry."Custom Field 2" := NewTrackingSpecification."Custom Field 2";
    End;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterCopyTrackingSpec', '', false, false)]
    local procedure OnAfterCopyTrackingSpec(var SourceTrackingSpec: Record "Tracking Specification"; var DestTrkgSpec: Record "Tracking Specification")
    Begin
        If ModifyRun = false then begin
            SourceTrackingSpec."Custom Field 1" := DestTrkgSpec."Custom Field 1";
            SourceTrackingSpec."Custom Field 2" := DestTrkgSpec."Custom Field 2";

        end else begin
            //For Modified value flow
            DestTrkgSpec."Custom Field 1" := SourceTrackingSpec."Custom Field 1";
            DestTrkgSpec."Custom Field 2" := SourceTrackingSpec."Custom Field 2";
        end;
    End;


    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterItemTrackingLinesOnBeforeInsert', '', false, false)]
    local procedure OnRegisterItemTrackingLinesOnBeforeInsert(var TrackingSpecification: Record "Tracking Specification"; var TempTrackingSpecification: Record "Tracking Specification" temporary; SourceTrackingSpecification: Record "Tracking Specification")
    Begin
        TrackingSpecification."Custom Field 1" := TempTrackingSpecification."Custom Field 1";
        TrackingSpecification."Custom Field 2" := TempTrackingSpecification."Custom Field 2";
    End;



    //Update modified custom field values For New Insert value Updated in Reservation Entry

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterEntriesAreIdentical', '', false, false)]
    local procedure OnAfterEntriesAreIdentical(ReservEntry1: Record "Reservation Entry"; ReservEntry2: Record "Reservation Entry"; var IdenticalArray: array[2] of Boolean)
    Begin
        IdenticalArray[2] :=
            (ReservEntry1."Custom Field 1" = ReservEntry2."Custom Field 1") and
            (ReservEntry1."Custom Field 2" = ReservEntry2."Custom Field 2")
    End;

    // [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterChangeOnBeforeAddItemTrackingToTempRecSet', '', false, false)]
    // local procedure OnRegisterChangeOnBeforeAddItemTrackingToTempRecSet(var OldTrackingSpecification: Record "Tracking Specification"; var NewTrackingSpecification: Record "Tracking Specification")
    // Begin
    //     OldTrackingSpecification."Custom Field 1" := NewTrackingSpecification."Custom Field 1";
    //     OldTrackingSpecification."Custom Field 2" := NewTrackingSpecification."Custom Field 2";
    // End;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterMoveFields', '', false, false)]
    local procedure OnAfterMoveFields(var TrkgSpec: Record "Tracking Specification"; var ReservEntry: Record "Reservation Entry")
    Begin
        ReservEntry."Custom Field 1" := TrkgSpec."Custom Field 1";
        ReservEntry."Custom Field 2" := TrkgSpec."Custom Field 2";
    End;

    //Custom Values flow to ILE
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertSetupTempSplitItemJnlLine', '', false, false)]
    local procedure OnBeforeInsertSetupTempSplitItemJnlLine(var TempItemJournalLine: Record "Item Journal Line" temporary; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    Begin
        TempItemJournalLine."Custom Field 1" := TempTrackingSpecification."Custom Field 1";
        TempItemJournalLine."Custom Field 2" := TempTrackingSpecification."Custom Field 2";
    End;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line")
    Begin
        NewItemLedgEntry."Custom Field 1" := ItemJournalLine."Custom Field 1";
        NewItemLedgEntry."Custom Field 2" := ItemJournalLine."Custom Field 2";
    End;

    //Assign Custom Values to Sales Shipments
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterValidateEvent', 'Lot No.', false, false)]
    local procedure TrackingSpecificatioOnAfterValidateEventLotNo(var Rec: Record "Tracking Specification")
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemLedgerEntry2: Record "Item Ledger Entry";
    Begin
        ItemLedgerEntry2.Reset();
        ItemLedgerEntry2.SetRange("Lot No.", Rec."Lot No.");
        If ItemLedgerEntry2.FindFirst() then begin

            Rec."Custom Field 1" := ItemLedgerEntry2."Custom Field 1";
            Rec."Custom Field 2" := ItemLedgerEntry2."Custom Field 2";

        end;
    End;

}
