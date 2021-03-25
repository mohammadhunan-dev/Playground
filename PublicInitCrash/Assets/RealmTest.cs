using UnityEngine;
using Realms;

class TestObject : RealmObject
{
    [PrimaryKey]
    int PrivateKey { get; set; }
    int Value;

    //TestObject() { }

    TestObject(int value)
    {
        Value = value;
    }
}

public class RealmTest : MonoBehaviour
{
    void Start()
    {
        Debug.Log(RealmConfiguration.GetPathToRealm());
        Realm.GetInstance();
    }
}
