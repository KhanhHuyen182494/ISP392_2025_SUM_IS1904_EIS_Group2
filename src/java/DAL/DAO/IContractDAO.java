/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import Model.Contract;

/**
 *
 * @author nongducdai
 */
public interface IContractDAO {
    //GET
    public Contract getContractByBookingId(String bookId);
    
    //ADD
    public boolean addContract(Contract c);
}
