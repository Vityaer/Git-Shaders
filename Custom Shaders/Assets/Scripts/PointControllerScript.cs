using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PointControllerScript : MonoBehaviour{
    
    Vector2 dir = Vector2.zero;
    [SerializeField] float speed = 0.1f;
    [SerializeField] Material material;
    private const string POINT_OFFSET = "_PointCircleOffset";
    void Update(){
    	if(material == null)
    		return;
    	if(Input.GetKey(KeyCode.S)) dir.y += -speed * Time.deltaTime; 
    	if(Input.GetKey(KeyCode.W)) dir.y += speed * Time.deltaTime; 
    	if(Input.GetKey(KeyCode.A)) dir.x += -speed * Time.deltaTime; 
    	if(Input.GetKey(KeyCode.D)) dir.x += speed * Time.deltaTime;
    	material.SetVector(POINT_OFFSET, dir);
    }
}
