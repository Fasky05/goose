struct Record { value: i64, text: u8[] }
enum Choice { Empty, Data { value: i64, text: u8[] } }

fn get_ref<T>(value: T&) -> T& { value }

fn change(record: Record&) -> Record {
    record.value = 2;
    return Record { value: 2, text: "text" };
}

fn change_array(values: Record[]&) -> Record[] {
    for value in values { value.value = 2; }
    return [Record { value: 2, text: "text" }];
}

fn change_choice(choice: Choice..&) -> Choice.. {
    match choice { Data &data => { data.value = 2; }, Empty => {} }
    return Choice.Data { value: 2, text: "text" };
}

fn main() {
    var record = Record { value: 1, text: "text" };
    print(record == change(record), " ", record.value);
    record.value = 1;
    print(get_ref(record) == change(record), " ", record.value);
    record.value = 1;
    print(record != change(record), " ", record.value);
    record.value = 1;
    print(get_ref(record) != change(record), " ", record.value);

    var values = [Record { value: 1, text: "text" }];
    print(values == change_array(values));
    for value in values { value.value = 1; }
    print(get_ref(values) == change_array(values));

    var choice: Choice.. = Choice.Data { value: 1, text: "text" };
    print(choice == change_choice(choice));
    match choice { Data &data => { data.value = 1; }, Empty => {} }
    print(get_ref(choice) == change_choice(choice));
}
