using Realms;
using UnityEngine;
using System.Collections;

class TestObject : RealmObject
{
    [PrimaryKey]
    int PrimaryKey { get; set; }

    internal int Value { get; set; }

    TestObject() { }

    internal TestObject(int primaryKey)
    {
        PrimaryKey = primaryKey;
    }
}

public class AwakeDestroyTest : MonoBehaviour
{
    private Realm realm; // = Realm.GetInstance(); <-- does not work, incorrect thread
    TestObject testObject;

    private void Awake()
    {
        realm = Realm.GetInstance();
        Debug.Log(realm.Config.DatabasePath);
        testObject = realm.Find<TestObject>(0);
        if (testObject == null)
        {
            testObject = new TestObject(0);
        }
        testObject.PropertyChanged += TestObject_PropertyChanged;
    }

    private void Start()
    {
        StartCoroutine(UpdateCoroutine());
    }

    private void OnMouseDown()
    {
        Destroy(gameObject);
    }

    private IEnumerator UpdateCoroutine()
    {
        while (true)
        {
            testObject.Value = 42;
            yield return new WaitForSeconds(1f);
        }
    }

    private void TestObject_PropertyChanged(object sender, System.ComponentModel.PropertyChangedEventArgs e)
    {
        Debug.Log("notification");
    }

    private void OnDestroy()
    {
        testObject.PropertyChanged -= TestObject_PropertyChanged;
        realm.Dispose();
    }
}
