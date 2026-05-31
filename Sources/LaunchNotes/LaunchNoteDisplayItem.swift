struct LaunchNoteDisplayItem: Identifiable {
    var id: LaunchNote.ID {
        note.id
    }

    let index: Int
    let note: LaunchNote
}
