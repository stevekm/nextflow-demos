// Start with a Channel of Sample IDs and associated files
Channel.from(["Sample1", "Sample1.txt"],
            ["Sample2", "Sample2.txt"],
            ["Sample3", "Sample3.txt"],
            ["Sample4", "Sample4.txt"],
            ["Sample5", "Sample5.txt"],
            ["Sample6", "Sample6.txt"])
        .into{samples; samples2; samples3; samples4}

// Channel of sample ID pairs
Channel.from(["Sample1", "Sample2"],
            ["Sample3", "Sample4"],
            ["Sample6", "Sample4"])
        .into{sample_pairs; sample_pairs2}

// get all the combinations of samples & pairs
samples.combine(sample_pairs) // [Sample1, Sample1.txt, Sample1, Sample2]
        .filter { items -> // only keep combinations where first sample matches pair sample ID #1
            def ID_1 = items[0]
            def pair_ID_1 = items[2]
            ID_1 == pair_ID_1
        }
        .map { items -> // re-order the elements for joining again on the 1st element
            def ID_1 = items[0]
            def file_1 = items[1]
            def pair_ID_1 = items[2]
            def pair_ID_2 = items[3]
            return [ pair_ID_1, file_1, pair_ID_2 ] // [Sample1, Sample1.txt, Sample2]
        }
        // combine again to get the samples & files again
        .combine(samples2) // [Sample1, Sample1.txt, Sample2, Sample1, Sample1.txt]
        .filter { items -> // keep only combinations where second pair ID matches the new joined ID
            def pair_ID_1 = items[0]
            def file_1 = items[1]
            def pair_ID_2 = items[2]
            def new_ID_2 = items[3]
            def file_2 = items[4]
            pair_ID_2 == new_ID_2
        } // [Sample1, Sample1.txt, Sample2, Sample2, Sample2.txt]
        // map again to put the items in the desired order
        .map { items ->
            def pair_ID_1 = items[0]
            def file_1 = items[1]
            def pair_ID_2 = items[2]
            def new_ID_2 = items[3]
            def file_2 = items[4]
            return [pair_ID_1, file_1, pair_ID_2, file_2] // [Sample6, Sample6.txt, Sample4, Sample4.txt]
        }
        .println()
