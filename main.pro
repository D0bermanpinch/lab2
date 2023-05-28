domains
    id = integer
    name = string
    address = string
    phone = string
    price = integer
    quantity = integer

predicates
    database(id, name, address, phone, price, quantity)
    addressByName(name, address)
    phoneByName(name, phone)
    averagePriceByID(id, average)
    sumQuantitiesByMedicine(name, minQuantity, count)
    run

clauses
    % Facts
    database(1, "Pharmacy #1", "123 Main Street", "111-111-111", 50, 20).
    database(2, "Pharmacy #2", "456 Elm Street", "222-222-222", 100, 15).
    database(3, "Pharmacy #3", "789 Oak Street", "333-333-333", 80, 25).
    database(4, "Pharmacy #4", "321 Pine Street", "444-444-444", 60, 30).
    database(5, "Pharmacy #5", "654 Maple Street", "555-555-555", 70, 10).
    database(6, "Pharmacy #6", "987 Cedar Street", "666-666-666", 90, 5).
    database(7, "Pharmacy #7", "234 Walnut Street", "777-777-777", 120, 15).
    database(8, "Pharmacy #8", "567 Birch Street", "888-888-888", 110, 10).
    database(9, "Pharmacy #9", "890 Pineapple Street", "999-999-999", 40, 20).
    database(10, "Pharmacy #10", "543 Orange Street", "000-000-000", 30, 5).
    database(11, "Pharmacy #11", "876 Lemon Street", "111-222-333", 80, 10).
    database(12, "Pharmacy #12", "109 Grape Street", "444-555-666", 60, 5).
    database(13, "Pharmacy #13", "432 Mango Street", "777-888-999", 70, 25).
    database(14, "Pharmacy #14", "765 Apple Street", "000-111-222", 90, 20).
    database(15, "Pharmacy #15", "098 Berry Street", "333-444-555", 100, 30).

    % Rule: Get the address of a pharmacy by name
    addressByName(Name, Address) :-
        database(_, Name, Address, _, _, _).

    % Rule: Get the phone number of a pharmacy by name
    phoneByName(Name, Phone) :-
        database(_, Name, _, Phone, _, _).

    % Rule: Get the average price of medicines in a pharmacy
    averagePriceByID(ID, Average) :-
        findall(Price, database(ID, _, _, _, Price, _), Prices),
        sumList(Prices, Sum),
        countList(Prices, Count),
        Average is Sum / Count.

    % Rule: Calculate the sum of quantities for a given medicine name
    sumQuantitiesByMedicine(Name, MinQuantity, Count) :-
        findall(Quantity, (database(_, _, _, _, _, Quantity), Quantity >= MinQuantity), Quantities),
        countList(Quantities, Count).

    % Helper predicate: Calculate the sum of elements in a list
    sumList([], 0).
    sumList([X | Xs], Sum) :-
        sumList(Xs, Rest),
        Sum is X + Rest.

    % Helper predicate: Calculate the count of elements in a list
    countList([], 0).
    countList([_ | Xs], Count) :-
        countList(Xs, Rest),
        Count is 1 + Rest.

    % Run predicate with example queries
    run :-
        write("Address of Pharmacy #2: "),
        addressByName("Pharmacy #2", Address),
        writeln(Address),

        write("Phone number of Pharmacy #6: "),
        phoneByName("Pharmacy #6", Phone),
        writeln(Phone),

        write("Average price of medicines in Pharmacy #10: "),
        averagePriceByID(10, Average),
        writeln(Average),

        write("Count of pharmacies with a quantity of at least 15: "),
        sumQuantitiesByMedicine("Medicine A", 15, Count),
        writeln(Count).
