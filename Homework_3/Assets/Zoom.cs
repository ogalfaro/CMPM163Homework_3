using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Zoom : MonoBehaviour
{
    int zoom = 20;
    int normal = 60;
    float smooth = 5;

    private bool isZoomed = false;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetMouseButtonDown(1)){
            isZoomed = !isZoomed;
        }
        if(isZoomed){
            GetComponent<Camera>().fieldOfView = Mathf.Lerp(GetComponent<Camera>().fieldOfView,zoom,Time.deltaTime * smooth);
        }
        else{
            GetComponent<Camera>().fieldOfView = Mathf.Lerp(GetComponent<Camera>().fieldOfView,normal,Time.deltaTime * smooth);
        }
    }
}
