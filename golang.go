// safe dictionary lookup
if val, ok := dict["foo"]; ok {
    //do something here
}

// safe casting
firstString, ok := firstVar.(string)
if (!ok) {
	fmt.Printf("firstString is not a string, do something about it! Value:'%v'\n", firstString)
}
// string to int
intVar, err := strconv.Atoi("100")

// new guid
import (
    "github.com/google/uuid"
)
guid := uuid.New.String()

// get keys from dictionary
keys := make([]int, len(mymap))
i := 0
for k := range mymap {
    keys[i] = k
    i++
}

// random int
import (
    "math/rand"
)
rand.Intn(100)
